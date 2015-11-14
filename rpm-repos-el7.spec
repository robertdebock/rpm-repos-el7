Name: rpm-repos
Version: 1
Release: 1.el7
BuildArch: noarch
Summary: Reposity for RPMs by Robert de Bock for Enterprise Linux 7
Group: Development/Tools
License: Apache Software License.

%description
Contains the repository that yum can use to install rpms.

%build
cat << EOF >> rpm-repos-el7.repo
[apache-tomcat-el7]
name=Apache Tomcat for Enterprise Linux 7
baseurl=https://s3-eu-west-1.amazonaws.com/apache-tomcat7.el7/
enabled=1
gpgcheck=0
EOF

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/
cp rpm-repos-el7.repo $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/

%clean
rm -rf $RPM_BUILD_ROOT
 
%files
%defattr(-,root,root,-)
/etc/yum.repos.d/rpm-repos-el7.repo
 
%changelog
* Fri Nov 13 2015 Robert de Bock <robert@meinit.nl> 1.1
- Initial release.
