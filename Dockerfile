ARG KSOPS_VERSION
ARG ARGOCD_VERSION

FROM viaductoss/ksops:${KSOPS_VERSION} AS ksops-builder

FROM quay.io/argoproj/argocd:${ARGOCD_VERSION}

ARG KSOPS_VERSION

LABEL ksops=${KSOPS_VERSION}

# Copy ksops and kustomize from the KSOPS image
COPY --from=ksops-builder /usr/local/bin/ksops /usr/local/bin/ksops
COPY --from=ksops-builder /usr/local/bin/kustomize /usr/local/bin/kustomize
