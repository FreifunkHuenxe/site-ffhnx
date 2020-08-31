GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
        gluon-alfred \
        gluon-respondd \
        gluon-autoupdater \
        gluon-setup-mode \
        gluon-config-mode-core \
        gluon-config-mode-autoupdater \
        gluon-config-mode-hostname \
        gluon-config-mode-geo-location \
        gluon-config-mode-contact-info \
        gluon-config-mode-tunneldigger \
        gluon-ebtables-filter-multicast \
        gluon-ebtables-filter-ra-dhcp \
        gluon-luci-admin \
        gluon-luci-autoupdater \
        gluon-luci-portconfig \
        gluon-luci-private-wifi \
        gluon-luci-wifi-config \
        gluon-luci-theme \
        gluon-next-node \
        gluon-mesh-vpn-tunneldigger \
        gluon-radvd \
        gluon-status-page \
        gluon-migrate-vpn \
        gluon-ssid-changer \
        gluon-tunneldigger-watchdog \
        iwinfo \
        iptables \
        haveged

GLUON_LANGS ?= de en

DEFAULT_GLUON_RELEASE := v2020.2+stable+ffhnx

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

# Do not build images for deprecated devices
GLUON_DEPRECATED ?= 0
