# Contributor: William Pitcock <nenolod@dereferenced.org>
# Maintainer: Eivind Uggedal <eivind@uggedal.com>
pkgname=nodejs
pkgver=0.12.4
pkgrel=0
pkgdesc='Evented I/O for V8 javascript'
url='http://nodejs.org/'
arch='all'
license='MIT'
makedepends="$depends_dev python openssl-dev zlib-dev libuv-dev c-ares-dev \
paxmark libuv-dev linux-headers"
subpackages="$pkgname-dev $pkgname-doc"
source="http://nodejs.org/dist/v$pkgver/node-v$pkgver.tar.gz"
_builddir="$srcdir"/node-v$pkgver

prepare() {
	local i
	cd "$_builddir"
	for i in $source; do
		case $i in
			*.patch) msg $i; patch -p1 -i "$srcdir"/$i || return 1;;
		esac
	done
}

build() {
	cd "$_builddir"
	./configure --prefix=/usr \
		--shared-zlib \
		--shared-libuv \
		--shared-openssl || return 1
	make -C out BUILDTYPE=Release mksnapshot || return 1
	paxmark -m out/Release/mksnapshot || return 1
	make || return 1
}

package() {
	local d
	cd "$_builddir"
	make DESTDIR="$pkgdir" install || return 1
	# paxmark so JIT works
	paxmark -m "$pkgdir"/usr/bin/node || return 1

	cp -pr "$pkgdir"/usr/lib/node_modules/npm/man "$pkgdir"/usr/share || return 1
	for d in doc html man; do
		rm -r "$pkgdir"/usr/lib/node_modules/npm/$d || return 1
	done
}

md5sums="c2b4deea212c0b7c2f86368c65fab312  node-v0.12.4.tar.gz"
sha256sums="3298d0997613a04ac64343e8316da134d04588132554ae402eb344e3369ec912  node-v0.12.4.tar.gz"
sha512sums="4d811a8f15068d2eea7e60a00c2803eb8ca8fd25b61ebf19aafc57be170abd75862d361ab9660e2be744efe66c69590b1a0a6b2bf8e3e72bb8d012c776262061  node-v0.12.4.tar.gz"
