[![tests](https://github.com/ddev/ddev-ibexa_cloud/actions/workflows/tests.yml/badge.svg)](https://github.com/ddev/ddev-ibexa_cloud/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2025.svg)

The [Ibexa Cloud](https://www.ibexa.co/products/ibexa-cloud) has its own CLI, instead of using the `platform` CLI. 

To use it we need:
* `ibexa_cloud` CLI installed inside `ddev-webserver`
* An `ibexa_cloud.yaml` host integration to use it.

This add-on provides those two things.

```bash
ddev get ddev-ibexa_cloud
ddev pull ibexa_cloud
```

**Contributed and maintained by @rfay**
