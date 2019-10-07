class Carthage < Formula
  desc "Decentralized dependency manager for Cocoa"
  homepage "https://github.com/Carthage/Carthage"
  url "https://github.com/ismetanin/Carthage.git",
      :tag      => "0.33.1",
      :revision => "b23f106f8120edb50b717948feb3af2cfe5dd924",
      :shallow  => false
  
  sha256 "8f7980e815d0255c9d239e7a1d1b42dabf34a49e2948fc3bb30b60264adc6727"

  depends_on :xcode => ["10.0", :build]

  def install
    if MacOS::Xcode.version >= "10.2" && MacOS.full_version < "10.14.4" && MacOS.version >= "10.14"
      odie "Xcode >=10.2 requires macOS >=10.14.4 to build Swift formulae."
    end

    system "make", "prefix_install", "PREFIX=#{prefix}"
    bash_completion.install "Source/Scripts/carthage-bash-completion" => "carthage"
    zsh_completion.install "Source/Scripts/carthage-zsh-completion" => "_carthage"
    fish_completion.install "Source/Scripts/carthage-fish-completion" => "carthage.fish"
  end

  test do
    (testpath/"Cartfile").write 'github "jspahrsummers/xcconfigs"'
    system bin/"carthage", "update"
  end
end
