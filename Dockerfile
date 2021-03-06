# Start at bioc devel
FROM bioconductor/bioconductor_docker:devel

# Update label for submission to bioconductor
LABEL name="jpwagner/bioconductor_docker_cytoverse" \
      version="devel" \
      url="https://github.com/jacobpwagner/bioconductor_docker_cytoverse" \
      maintainer="jpwagner@fredhutch.org" \
      description="Bioconductor docker image with bundled RGLab cytometry packages" \
      license="Artistic-2.0"

WORKDIR cytoverse_repos

RUN R -e 'BiocManager::install(version = "devel", ask = FALSE)'

RUN git clone https://github.com/RGLab/RProtoBufLib --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/cytolib --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/flowCore --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/flowViz --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/ncdfFlow --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/flowWorkspace --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/flowWorkspaceData --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/flowClust --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/flowStats --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/ggcyto --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/openCyto --depth=1 --branch=master --single-branch \
    && git clone https://github.com/RGLab/CytoML --depth=1 --branch=master --single-branch

RUN R -e 'devtools::install_deps("RProtoBufLib", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build RProtoBufLib --no-build-vignettes \
    && R CMD INSTALL RProtoBufLib_* \
    && R -e 'devtools::install_deps("cytolib", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build cytolib --no-build-vignettes \
    && R CMD INSTALL cytolib_* \
    && R -e 'devtools::install_deps("flowCore", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build flowCore --no-build-vignettes \
    && R CMD INSTALL flowCore_* \
    && R -e 'devtools::install_deps("flowViz", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build flowViz --no-build-vignettes \
    && R CMD INSTALL flowViz_* \
    && R -e 'devtools::install_deps("ncdfFlow", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build ncdfFlow --no-build-vignettes \
    && R CMD INSTALL ncdfFlow_* \
    && R -e 'devtools::install_deps("flowWorkspace", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build flowWorkspace --no-build-vignettes \
    && R CMD INSTALL flowWorkspace_* \
    && R -e 'devtools::install_deps("flowWorkspaceData", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build flowWorkspaceData --no-build-vignettes \
    && R CMD INSTALL flowWorkspaceData_* \
    && R -e 'devtools::install_deps("flowClust", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build flowClust --no-build-vignettes \
    && R CMD INSTALL flowClust_* \
    && R -e 'devtools::install_deps("flowStats", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build flowStats --no-build-vignettes \
    && R CMD INSTALL flowStats_* \
    && R -e 'devtools::install_deps("ggcyto", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build ggcyto --no-build-vignettes \
    && R CMD INSTALL ggcyto_* \
    && R -e 'devtools::install_deps("openCyto", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build openCyto --no-build-vignettes \
    && R CMD INSTALL openCyto_* \
    && R -e 'devtools::install_deps("CytoML", repos=BiocManager::repositories(version = "devel"), upgrade = "never")' \
    && R CMD build CytoML --no-build-vignettes \
    && R CMD INSTALL CytoML_*

RUN rm -rf /cytoverse_repos
