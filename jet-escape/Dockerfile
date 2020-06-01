FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
		&& rm -r /var/lib/apt/lists/*
COPY IntelliJIDEALicenseServer_linux_amd64 /root/
WORKDIR /root

EXPOSE 1027
CMD ["/root/IntelliJIDEALicenseServer_linux_amd64"]
