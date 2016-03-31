Name:                   holodev
Summary:                A holodeck developers
Version:                0.4
Release:                3%{?dist}
License:                GPL-2.0+
Source0:                https://github.com/lappis-tools/%{name}/archive/%{version}.tar.gz#/%{name}-%{version}.tar.gz
Url:                    https://github.com/lappis-tools/holodev
BuildArch:              noarch
Group:                  Development/Tools
BuildRequires:          bridge-utils, debootstrap, lxc, sudo, git, bash-completion, shunit2, ebtables, dnsmasq
Requires:               %{_bindir}/virsh, bridge-utils, debootstrap, lxc, sudo, git, bash-completion

%description
Tool that makes it easier to create Linux containers for development using Debian systems.

%prep
%autosetup -n %{name}-%{version}

%build

# TODO: make this section work
#%check
#make test
#
#%post
#holodev setup

%install
# install holodev binary
install -d -m 0755 $RPM_BUILD_ROOT%{_bindir}
install -m 0755 holodev $RPM_BUILD_ROOT%{_bindir}/holodev

# install holodev bash-completion
install -d -m 0755 $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
install -m 0644 -T debian/holodev.bash-completion $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/holodev.bash-completion

%check
make test

%post
holodev setup

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc README.md
%config %{_sysconfdir}/bash_completion.d/holodev.bash-completion
%{_bindir}/holodev

%changelog
* Thu Mar 31 2016 Carlos Coêlho <carlospecter@gmail.com> - 0.4-3
- Added post install setup

* Thu Mar 31 2016 Carlos Coelho <carlospecter@gmail.com> - 0.4-2
- Added bash-completion

* Thu Mar 31 2016 Carlos Coêlho <carlospecter@gmail.com> - 0.4-1
- Initial RPM release
