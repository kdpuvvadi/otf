<p align="center">
  <a href="https://github.com/leg100/otf"><img alt="otf logo" height="64" src="https://docs.otf.ninja/latest/images/logo.svg">
  </a>
</p>

Docker images for otf, an Open Source alternative to Terraform Cloud. 

- Original Repo: https://github.com/leg100/otf
- Documentation: https://otf.ninja

## Docker compose for otf

```yaml
services:
  postgres:
    image: postgres:16-alpine
    ports:
      - "5432:5432"
    environment:
     - POSTGRES_PASSWORD=postgres

  otfd:
    image: ghcr.io/kdpuvvadi/otf:latest
    container_name: otf
    ports:
      - "8080:8080"
    depends_on:
      postgres:
    environment:
      - OTF_DATABASE=postgres://postgres:postgres@postgres/postgres?sslmode=disable
      - OTF_SECRET=secret
      - OTF_SITE_TOKEN=site-token
      #- OTF_SSL=true
      #- OTF_CERT_FILE=/fixtures/cert.pem
      #- OTF_KEY_FILE=/fixtures/key.pem
      - OTF_LOG_HTTP_REQUESTS=true
      #- SSL_CERT_FILE=/fixtures/cert.pem
      - OTF_HOSTNAME=otf.example.com
```

## Docker compose for otf agent

please refer to [documentation](https://docs.otf.ninja/latest/agents/#walkthrough-pool-agents) on how to generate token for deploying agents

```yaml
services:
  otf-agent:
    image: ghcr.io/kdpuvvadi/otf-agent:latest
    container_name: otf-agent
    environment:
      - OTF_URL=https://otf.example.com
      - OTF_TOKEN=token
    command: --token OTF_TOKEN --url OTF_URL
```
