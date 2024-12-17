Name:           btusb-mt7925-extended-pids
Version:        1.4
Release:        1%{?dist}
Summary:        Extended PID support for the mt7925 chipset

License:        GPLv2
URL:            https://example.com
Source0:        %{name}.tar.gz
BuildRequires:  dkms

%description
This package provides extended PID support for the mt7925 chipset that is not yet included in the mainline kernel.
Mainly 0xe124, found in Gigabyte Aorus Elite X870 and other x870 boards

%global debug_package %{nil}

%prep
%setup -q -n %{name}

%build
sed "s/@PKGNAME@/%{name}/" dkms.conf.template | sed "s/@VERSION@/%{version}/" > dkms.conf
sed "s/@VERSION@/%{version}/" btusb.c.template > btusb.c

%install
# Install the DKMS source into /usr/src
mkdir -p %{buildroot}/usr/src/%{name}-%{version}/
cp -r * %{buildroot}/usr/src/%{name}-%{version}/
mkdir -p %{buildroot}/lib/systemd/system-sleep
cp -p btusb_7925_sleep %{buildroot}/lib/systemd/system-sleep/


%files
/usr/src/%{name}-%{version}
/lib/systemd/system-sleep/btusb_7925_sleep

%post
# Register the module with DKMS
dkms add -m %{name} -v %{version}
dkms build -m %{name} -v %{version}
dkms install -m %{name} -v %{version}

%preun
# Remove the module from DKMS when the package is uninstalled
dkms remove -m %{name} -v %{version} --all

%changelog

* Mon Dec 16 2024 Dejan Noveski <dr.mote@gmail.com> - 1.4-1
- Fix for 6.12

* Wed Dec 11 2024 Dejan Noveski <dr.mote@gmail.com> - 1.2-1
- Fix for 6.11

* Tue Nov 19 2024 Dejan Noveski <dr.mote@gmail.com> - 1.2-1
- DKMS Fix
- Better sleep script

* Sat Nov 16 2024 Dejan Noveski <dr.mote@gmail.com> - 1.0-1
- Initial release with extended PID support for mt7925 chipset.
- Sleep fix
