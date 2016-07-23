system.pkgs:
  pkg.installed:
    - pkgs:
      - dfc
      - dstat
      - fdupes
      - glances
      - htop
      - ncdu
      - smartmontools
      - sysstat
      - tree

smartmontools:
  service.running:
    - require:
      - pkg: system.pkgs
    - watch:
      - file: /etc/default/smartmontools
      - file: /etc/smartd.conf

smartctl -s on /dev/sda:
  cmd.run:
    - onlyif: "smartctl -i /dev/sda | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: system.pkgs

smartctl -s on /dev/sdb:
  cmd.run:
    - onlyif: "smartctl -i /dev/sdb | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: system.pkgs

/etc/default/smartmontools:
  file.managed:
    - source: salt://system/smartmontools-default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: system.pkgs

/etc/smartd.conf:
  file.managed:
    - source: salt://system/smartd.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: system.pkgs
