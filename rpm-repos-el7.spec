Name: rpm-repos-el7
Version: 1
Release: 1
BuildArch: noarch
Summary: Reposity for RPMs by Robert de Bock for Enterprise Linux 7
Group: Development/Tools
License: Apache Software License.

%description
Contains the repository that yum can use to install rpms.

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/
cp /data/rpmbuild/SOURCES/rpm-repos-el7.repo $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/

%clean
rm -rf $RPM_BUILD_ROOT
 
%files
%defattr(-,root,root,-)
/etc/yum.repos.d/rpm-repos-el7.repo
 
%changelog
* Fri Nov 13 2015 Robert de Bock <robert@meinit.nl> 1.1
- Initial release.
