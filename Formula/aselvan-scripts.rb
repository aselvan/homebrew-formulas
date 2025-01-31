class AselvanScripts < Formula
  desc "aselvan-scripts --- a collection of handy utility scripts for macOS & Linux"
  homepage "https://github.com/aselvan/scripts"

  ### all 3 of these varibables below should be updated on new release
  version "v25.01.31"
  url "https://github.com/aselvan/scripts/archive/refs/tags/v25.01.31.tar.gz"
  sha256 "f21d48244fed08a9c3f8e2a32cf50a41927cb3afc535e1f51865b6773308dfc0"
  
  # licence release
  license "MIT"

  # dependency (we need latest bash on macOS)
  depends_on "bash"

  def install
    # Install everything directly to the prefix (Cellar directory)
    prefix.install Dir["*"]

    # Make scripts executable (within the prefix) --- NOT needed when files are already set to be +x in source location
    #Dir[prefix/"*.sh"].each { |f| chmod "+x", f } # or Dir[prefix/"scripts/*.sh"] if they are in a scripts/ folder    
  end

  def caveats
    <<~EOS
    =================================================================================
    #{name} #{version}

    While this scripts content is installed, it requires the following environment
    variables SCRIPTS_GITHUB and PATH set in ~/.bashrc to function. You *must* add 
    the following to your ~/.bashrc variable for these scripts to work. Execute both 
    commands in the order listed below on the terminal to insert it at the end of 
    your ~/.bashrc. i.e. just copy/paste each line and press enter.

    echo 'export SCRIPTS_GITHUB="#{opt_prefix}"' >> ~/.bashrc
    echo 'export PATH="#{HOMEBREW_PREFIX}/bin:#{opt_prefix}/utils:#{opt_prefix}/security:#{opt_prefix}/tools:#{opt_prefix}/macos:#{opt_prefix}/firewall:$PATH"' >> ~/.bashrc

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
