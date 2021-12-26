{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

{% for instance_name, instance in syncthing.instances.items() %}
syncthing_docker_service_installed_for_{{ instance.user }}:
  file.managed:
    - name: /etc/systemd/system/syncthing-docker-{{ instance.user }}.service
    - source: salt://syncthing-docker/files/syncthing-docker.service
    - template: jinja
    - context:
        syncthing: {{instance|tojson}}

  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: syncthing_docker_service_installed_for_{{ instance.user }}

syncthing_docker_service_running_for_{{ instance.user }}:
  service.running:
    - name: syncthing-docker-{{ instance.user }}
    - enable: True
    - watch:
      - module: syncthing_docker_service_installed_for_{{ instance.user }}
{% endfor %}