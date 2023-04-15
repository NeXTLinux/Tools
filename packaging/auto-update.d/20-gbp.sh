# This file is sourced by bin/auto-update

gbp_conf=debian/gbp.conf

# Add a debian/gbp.conf file
if [ ! -e $gbp_conf ] || ! grep -q nextlinux $gbp_conf || ! grep -q debian-tag $gbp_conf; then
    cat >$gbp_conf <<END
[DEFAULT]
debian-branch = nextlinux/master
debian-tag = nextlinux/%(version)s
pristine-tar = True

[pq]
patch-numbers = False

[dch]
multimaint-merge = True
END

    if grep -q "XSBC-Original-Maintainer:" debian/control && ! grep -q "\[import-dsc\]" $gbp_conf; then
	cat >>$gbp_conf <<END

[import-dsc]
debian-branch = debian
debian-tag = debian/%(version)s
END
    fi

    record_change "Configure git-buildpackage for nextlinux" $gbp_conf
fi
