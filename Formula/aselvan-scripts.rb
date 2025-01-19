class AselvanScripts < Formula
  desc "aselvan-scripts --- a collection of handy utility scripts for macOS & Linux"
  homepage "https://github.com/aselvan/scripts"
  version "v25.01.18"
  url "https://github.com/aselvan/scripts/archive/refs/tags/v25.01.18.tar.gz"
  sha256 "e10f4c0fc40a6c33bbf3af5f60b5033d1681fbab84be39a26dfa1a2005a35348"
  license "MIT"

  def install
    # Install everything directly to the prefix (Cellar directory)
    prefix.install Dir["*"]

    # Make scripts executable (within the prefix) --- NOT needed when files are already set to be +x in source location
    #Dir[prefix/"*.sh"].each { |f| chmod "+x", f } # or Dir[prefix/"scripts/*.sh"] if they are in a scripts/ folder    
  end

  def caveats
    <<~EOS
    ============================================================================
    #{name}:

    While this scripts content is installed, it requires the following environment
    variables GITHUB_SCRIPTS_HOME and PATH set in ~/.bashrc to function. You *must* 
    add the following to your ~/.bashrc variable for these scripts to work. Execute 
    both commands in the order listed below on the terminal to insert it at the end 
    of your ~/.bashrc. i.e. just copy/paste each line and press enter.

    echo 'export GITHUB_SCRIPTS_HOME="#{opt_prefix}"' >> ~/.bashrc
    echo 'export PATH="$PATH:#{opt_prefix}/utils:#{opt_prefix}/security:#{opt_prefix}/tools:#{opt_prefix}/macos:#{opt_prefix}/firewall"' >> ~/.bashrc

    ============================================================================
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
    #assert_match "expected output", shell_output("#{bin}/#{name}/some_script.sh --version")
  end
end
