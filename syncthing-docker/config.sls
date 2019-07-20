{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

{% if syncthing.config_source %}

syncthing_docker_config_dir_for_{{ syncthing.user }}:
  file.directory:
    - name: {{ syncthing.config }}
    - makedirs: True
    - user: {{ syncthing.user }}
    - group: {{ syncthing.group }}

syncthing_docker_copy_config_for_{{ syncthing.user }}:
  file.recurse:
    - name: {{ syncthing.config }}
    - source: {{ syncthing.config_source }}
    - user: {{ syncthing.user }}
    - group: {{ syncthing.group }}

{% endif %}