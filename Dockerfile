ARG KSOPS_VERSION=v4.4.0
ARG ARGOCD_VERSION=v3.2.3
# KUSTOMIZE_VERSION is used only as a label; the actual binary comes from the KSOPS image.
# This value should match the Kustomize version bundled in the specified KSOPS_VERSION image.
ARG KUSTOMIZE_VERSION=v5.0.0

FROM viaductoss/ksops:${KSOPS_VERSION} AS ksops-builder

FROM quay.io/argoproj/argocd:${ARGOCD_VERSION}

ARG KSOPS_VERSION
ARG KUSTOMIZE_VERSION

LABEL ksops=${KSOPS_VERSION}
LABEL kustomize=${KUSTOMIZE_VERSION}

# Copy ksops and kustomize from the KSOPS image
COPY --from=ksops-builder /ksops /usr/local/bin/ksops
COPY --from=ksops-builder /kustomize /usr/local/bin/kustomize
