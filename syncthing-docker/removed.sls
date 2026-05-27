{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

{% for instance_name, instance in syncthing.instances.items() %}
syncthing_docker_service_stopped_for_{{ instance.name }}:
  service.dead:
    - name: syncthing-docker-{{ instance.name }}
    - enable: False

syncthing_docker_service_removed_for_{{ instance.name }}:
  file.absent:
    - name: /etc/systemd/system/syncthing-docker-{{ instance.name }}.service
    - require:
      - service: syncthing_docker_service_stopped_for_{{ instance.name }}

  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: syncthing_docker_service_removed_for_{{ instance.name }}

{% endfor %}
