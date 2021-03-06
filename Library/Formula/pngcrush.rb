require 'formula'

class Pngcrush < Formula
  homepage 'http://pmt.sourceforge.net/pngcrush/'
  # Stay at least one version behind and use the old-versions directory,
  # because tarballs are routinely removed and upstream won't change this
  # practice.
  url 'https://downloads.sourceforge.net/project/pmt/pngcrush/old-versions/1.7/1.7.70/pngcrush-1.7.70.tar.gz'
  sha1 '77a6e092ba192b24f4d51014e7a67ecb50f842e9'

  def install
    # Required to successfully build the bundled zlib 1.2.6
    ENV.append_to_cflags "-DZ_SOLO"
    # Required to enable "-cc" (color counting) option (disabled by default since 1.5.1)
    ENV.append_to_cflags "-DPNGCRUSH_COUNT_COLORS"

    system "make", "CC=#{ENV.cc}",
                   "LD=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "LDFLAGS=#{ENV.ldflags}"
    bin.install 'pngcrush'
  end
end
