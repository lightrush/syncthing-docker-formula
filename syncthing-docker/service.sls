{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

{% for instance_name, instance in syncthing.instances.items() %}
syncthing_docker_service_installed_for_{{ instance.name }}:
  file.managed:
    - name: /etc/systemd/system/syncthing-docker-{{ instance.name }}.service
    - source: salt://syncthing-docker/files/syncthing-docker.service
    - template: jinja
    - context:
        syncthing: {{instance|tojson}}

  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: syncthing_docker_service_installed_for_{{ instance.name }}

syncthing_docker_service_running_for_{{ instance.name }}:
  service.running:
    - name: syncthing-docker-{{ instance.name }}
    - enable: True
    - watch:
      - module: syncthing_docker_service_installed_for_{{ instance.name }}
{% endfor %}