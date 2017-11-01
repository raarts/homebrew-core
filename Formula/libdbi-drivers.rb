class LibdbiDrivers < Formula
  desc "Database-specific drivers for the libdbi framework"
  homepage "http://libdbi-drivers.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/libdbi-drivers/libdbi-drivers/libdbi-drivers-0.9.0/libdbi-drivers-0.9.0.tar.gz"
  sha256 "43d2eacd573a4faff296fa925dd97fbf2aedbf1ae35c6263478210c61004c854"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libdbi"
  depends_on "mysql" => [:build, :optional]
  depends_on "postgresql" => [:build, :optional]

  def install
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-docs",
                          "--with-sqlite3",
                          "--with-pgsql",
                          "--with-pgsql-incdir=#{Formula["postgresql"].opt_prefix}/include",
                          "--with-pgsql-libdir=#{Formula["postgresql"].opt_prefix}/lib",
                          "--with-mysql",
                          "--with-mysql-incdir=#{Formula["mysql"].opt_prefix}/include/mysql",
                          "--with-mysql-libdir=#{Formula["mysql"].opt_prefix}/lib"
    system "/usr/bin/make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libdbi-drivers`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
