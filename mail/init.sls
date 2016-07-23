mail.pkgs:
  pkg.installed:
    - pkgs:
      - mutt
      - heirloom-mailx
      - ssmtp

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://mail/ssmtp.conf #salt:// est équivalent à /srv/salt
    - mode: 640 #chmod

/etc/ssmtp/revaliases:
  file.managed:
    - source: salt://mail/revaliases
    - mode: 640
