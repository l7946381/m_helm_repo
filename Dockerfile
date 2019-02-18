FROM python:3

WORKDIR /root/

COPY ./requirements.txt ./

RUN pip install -r requirements.txt

COPY ./*.* ./

VOLUME ["/data/m_helm_repo"]

CMD ["/data/m_helm_repo/update.sh"]
