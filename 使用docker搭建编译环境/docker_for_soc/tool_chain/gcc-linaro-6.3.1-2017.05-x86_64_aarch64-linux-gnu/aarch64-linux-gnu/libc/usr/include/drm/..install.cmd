cmd_/home/tcwg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu/usr/include/drm/.install := /bin/bash scripts/headers_install.sh /home/tcwg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu/usr/include/drm ./include/uapi/drm amdgpu_drm.h drm.h drm_fourcc.h drm_mode.h drm_sarea.h exynos_drm.h i810_drm.h i915_drm.h mga_drm.h msm_drm.h nouveau_drm.h qxl_drm.h r128_drm.h radeon_drm.h savage_drm.h sis_drm.h tegra_drm.h vc4_drm.h via_drm.h virtgpu_drm.h vmwgfx_drm.h; /bin/bash scripts/headers_install.sh /home/tcwg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu/usr/include/drm ./include/drm ; /bin/bash scripts/headers_install.sh /home/tcwg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu/usr/include/drm ./include/generated/uapi/drm ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/tcwg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu/usr/include/drm/$$F; done; touch /home/tcwg-buildslave/workspace/tcwg-make-release/builder_arch/amd64/label/tcwg-x86_64-build/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu/usr/include/drm/.install
