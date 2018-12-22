{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

syncthing_docker_home_dir_for_{{ syncthing.user }}:
  file.directory:
    - name: {{ syncthing.home }}
    - makedirs: True
    - user: {{ syncthing.user }}
    - group: {{ syncthing.group }}
