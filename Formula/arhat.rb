class Arhat < Formula
  desc "The reference agent implementation of aranya-proto and EdgeDevice"
  homepage "https://github.com/arhat-dev/arhat"
  version "v0.0.1"
  bottle :unneeded
  conflicts_with "arhat"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/arhat-dev/arhat/releases/download/v0.0.1/arhat.darwin.amd64"
      # sha256 ""
    elsif Hardware::CPU.arm?
      url "https://github.com/arhat-dev/arhat/releases/download/v0.0.1/arhat.darwin.arm64"
      # sha256 ""
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/arhat-dev/arhat/releases/download/v0.0.1/arhat.linux.amd64"
      sha256 ""
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/arhat-dev/arhat/releases/download/v0.0.1/arhat.linux.arm64"
        # sha256 ""
      else
        url "https://github.com/arhat-dev/arhat/releases/download/v0.0.1/arhat.linux.armv7"
        # sha256 ""
      end
    end
  end

  def install
    bin.install "arhat"
  end

  plist_options manual: "arhat -c /path/to/config.yaml"

  def plist
    <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Debug</key>
          <true/>

          <key>KeepAlive</key>
          <dict>
            <key>SuccessfulExit</key>
            <false/>
          </dict>

          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/arhat</string>
            <string>-c</string>
            <string>#{var}/config.yaml</string>
          </array>

          <key>RunAtLoad</key>
          <true/>

          <key>WorkingDirectory</key>
          <string>#{var}</string>

          <key>StandardErrorPath</key>
          <string>#{var}/log/arhat.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/arhat.log</string>

          <key>UserName</key>
	        <string>root</string>
        </dict>
      </plist>
    PLIST
  end

  test do
    system "#{bin}/arhat --version"
  end
end
