FROM continuumio/miniconda3

WORKDIR /workspace

COPY environment.yml /workspace/
RUN conda env create -f environment.yml

COPY entrypoint.sh /workspace/
RUN chmod +x /workspace/entrypoint.sh

COPY . /workspace/

ENTRYPOINT ["/workspace/entrypoint.sh"]
