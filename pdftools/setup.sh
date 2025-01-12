#!/bin/bash

if [ -d "/opt/pdftools" ];
then
    rm -rf /opt/pdftools
fi

mkdir /opt/pdftools

git clone https://github.com/Danpythonman/pdfextract.git /opt/pdftools

python3 -m venv /opt/pdftools/venv

/opt/pdftools/venv/bin/pip3 install /opt/pdftools

echo "#!/bin/bash" > /usr/local/bin/pdftools
echo "" >> /usr/local/bin/pdftools
echo "/opt/pdftools/venv/bin/python3 /opt/pdftools/src/pdftools/interface/cli \"$@\"" >> /usr/local/bin/pdftools

chmod +x /usr/local/bin/pdftools
