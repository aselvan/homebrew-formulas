class AselvanScripts < Formula
  desc "aselvan-scripts --- a collection of handy utility scripts for macOS & Linux"
  homepage "https://github.com/aselvan/scripts"
  version "v25.01.18"
  url "https://github.com/aselvan/scripts/archive/refs/tags/v25.01.18.tar.gz"
  sha256 "e10f4c0fc40a6c33bbf3af5f60b5033d1681fbab84be39a26dfa1a2005a35348"
  license "MIT"

  def install
    # Install everything to the Cellar (handled automatically)

    # Create the single symlink in /usr/local/bin pointing to the installation directory
    bin.install_symlink prefix => name
  end

  caveats do
    <<~EOS
      To add #{name} to your PATH, add the following line to your ~/.bashrc:
        export GITHUB_SCRIPTS_HOME="#{opt_bin}"
        export PATH="$PATH:#{opt_bin}/utils:#{opt_bin}/security:#{opt_bin}/tools:#{opt_bin}/macos:#{opt_bin}/firewall"

      Or, if you prefer, you can use the following command:
        echo 'export GITHUB_SCRIPTS_HOME="#{opt_bin}"' >> ~/.bashrc
        echo 'export PATH="$PATH:#{opt_bin}/utils:#{opt_bin}/security:#{opt_bin}/tools:#{opt_bin}/macos:#{opt_bin}/firewall"' >> ~/.bashrc
    EOS
  end

  test do
    assert_predicate bin/name, :exist?
    #assert_match "expected output", shell_output("#{bin}/#{name}/some_script.sh --version")
  end
end
