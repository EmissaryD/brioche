#!/bin/bash
function readlink(){
	coreutils --coreutils-prog=readlink "$@"
}

if base=$(readlink "$0" 2>/dev/null); then
	case $base in
		/*) base=$(readlink -f "$0" 2>/dev/null);; # if $0 is abspath symlink, make symlink fully resolved.
		*)  base=$(dirname "$0")/"${base}";;
	esac
else
	case $0 in
		/*) base=$0;;
		*)  base=${PWD:-`pwd`}/$0;;
	esac
fi
basedir=${base%/*}
LD_ARGV0_REL="../bin/sommelier" \
	exec "${basedir}/..#{@peer_cmd_prefix}" \
	--library-path \
	"${basedir}/../#{ARCH_LIB}" \
	--inhibit-rpath '' \
	"${base}.elf" \
	"$@"
