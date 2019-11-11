#!/bin/bash
#set -x
outdir="$1.out"
filename="${1##*/}" #extract filename, without path
outfile=$outdir/${filename/.p7m/}
mkdir $outdir
openssl pkcs7 -inform DER -in "$1" -print_certs -out "$outdir/signer.pem"
openssl smime -verify -in "$1" -inform der -noverify -signer  "$outdir/signer.pem" -out "$outfile" 2>/dev/null
xdg-open "$outfile"
#if you don't need extracted file uncoment the following line
#rm "$outdir/signer.pem"; rm "$outfile"; rmdir $outdir
