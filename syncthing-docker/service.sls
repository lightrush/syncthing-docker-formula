{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

syncthing_docker_service_installed_for_{{ syncthing.user }}:
  file.managed:
    - name: /etc/systemd/system/syncthing-docker-{{ syncthing.user }}.service
    - source: salt://syncthing-docker/files/syncthing-docker.service
    - template: jinja

  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: syncthing_docker_service_installed_for_{{ syncthing.user }}

syncthing_docker_service_running_for_{{ syncthing.user }}:
  service.running:
    - name: syncthing-docker-{{ syncthing.user }}
    - enable: True
    - watch:
      - module: syncthing_docker_service_installed_for_{{ syncthing.user }}
