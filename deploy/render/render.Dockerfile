FROM baserow/baserow:1.10.1
RUN apt-get remove -y postgresql postgresql-contrib redis-server

# ENV DATA_DIR=/baserow/data
# # We have to build the data dir in the docker image as Caddy does not allow it in their
# # runtime filesystem. We chown to their www-data user's uid and gid at the end.
# RUN mkdir -p "$DATA_DIR" && \
#     chown -R 9999:9999 "$DATA_DIR"

COPY deploy/render/render_env.sh /baserow/supervisor/env/render_env.sh


ENTRYPOINT ["/baserow.sh"]
CMD ["start"]