{%- from "syncthing-docker/map.jinja" import syncthing with context -%}

{% for instance_name, instance in syncthing.instances.items() %}
{% if instance.config_source %}

syncthing_docker_config_dir_for_{{ instance.user }}:
  file.directory:
    - name: {{ instance.config }}
    - makedirs: True
    - user: {{ instance.user }}
    - group: {{ instance.group }}

syncthing_docker_copy_config_for_{{ instance.user }}:
  file.recurse:
    - name: {{ instance.config }}
    - source: {{ instance.config_source }}
    - user: {{ instance.user }}
    - group: {{ instance.group }}

{% endif %}
{% endfor %}