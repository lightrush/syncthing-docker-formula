{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

{% for instance_name, instance in syncthing.instances.items() %}
syncthing_docker_home_dir_for_{{ instance.user }}:
  file.directory:
    - name: {{ instance.home }}
    - makedirs: True
    - user: {{ instance.user }}
    - group: {{ instance.group }}
{% endfor %}