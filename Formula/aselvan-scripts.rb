class AselvanScripts < Formula
  desc "aselvan-scripts --- a collection of handy utility scripts for macOS & Linux"
  homepage "https://github.com/aselvan/scripts"

  ### all 3 of these varibables below should be updated on new release
  version "v25.02.21"
  url "https://github.com/aselvan/scripts/archive/refs/tags/v25.02.21.tar.gz"
  sha256 "bc368ba04fec7ee0c87fc598a4cc5db022ffee4c229d2bc608f6ef3f4d548835"
  
  # licence release
  license "MIT"

  # dependency
  #   We need latest bash on macOS and few basic things. I am not including every pakage
  #   scripts in this repo depends on, but user can install as needed.
  depends_on "bash"
  depends_on "curl"
  depends_on "wget"
  depends_on "zbar"
  depends_on "exiftool"
  depends_on "oath-toolkit"
  depends_on "imagemagick"

  def install
    # Install everything directly to the prefix (Cellar directory)
    prefix.install Dir["*"]

    # Make scripts executable (within the prefix) --- NOT needed when files are already set to be +x in source location
    #Dir[prefix/"*.sh"].each { |f| chmod "+x", f } # or Dir[prefix/"scripts/*.sh"] if they are in a scripts/ folder    
  end

  def caveats
    # check for shell and change the rc file accordingly
    resfile = ".zshrc"
    shell = ENV['SHELL']
    if shell.include?("bash")
      resfile = ".bashrc"
    end
    
    <<~EOS
    =================================================================================
    #{name} #{version}

    While this scripts content is installed, it requires the following environment
    variables SCRIPTS_GITHUB and PATH set in ~/#{resfile} to function. You *must* 
    add the following to your ~/#{resfile} for the scripts to work. Execute both 
    commands in the order listed below on the terminal to insert it at the end 
    of your ~/#{resfile}. i.e. just copy/paste each line and press enter.

    echo 'export SCRIPTS_GITHUB="#{opt_prefix}"' >> ~/#{resfile}
    echo 'export PATH="#{HOMEBREW_PREFIX}/bin:#{opt_prefix}/utils:#{opt_prefix}/security:#{opt_prefix}/tools:#{opt_prefix}/macos:#{opt_prefix}/firewall:$PATH"' >> ~/#{resfile}

    NOTE: You only need to do this once at the very first install. Skip for updates.
    =================================================================================
    EOS
  end

  test do
    if File.exist?(opt_prefix)
      puts "#{name} is installed."
      puts "Location: #{opt_prefix}"
      puts "Version:  #{version}"
    else
      puts "#{name}: is not installed" 
    end
    assert_predicate opt_prefix, :exist?
   
    # assert if the exit code is 0 and the output matches "Installed"
    ENV["SCRIPTS_GITHUB"] = "#{opt_prefix}"
    output = `#{opt_prefix}/check_install.sh`
    exit_code = $?.exitstatus
    puts "#{output}"
    puts "ExitCode: #{exit_code}\n"
  end
end
