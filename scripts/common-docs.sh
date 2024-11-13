#!/usr/bin/env bash

PATH_ROOT=${1:-"."}
PATH_NAME="common"
PATH_TO_DOCS="${PATH_ROOT}/${PATH_NAME}/docs"

ALLOWED_EXTENSIONS="*.tpl"

if [ ! -d "${PATH_TO_DOCS}" ]; then
  mkdir -p "${PATH_TO_DOCS}"
fi

cat<<EOF > "${PATH_TO_DOCS}/README.md"
<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="https://avatars.githubusercontent.com/u/180111812?s=400&u=cda6d53ade890c5d47426504081e4fcb1167199d&v=4" style="width: 100px;">
</a>
</p>

# Common components
EOF

# Keep module docs up to date
find "./${PATH_NAME}" -type f -name "${ALLOWED_EXTENSIONS}" -print | while read -r f; do
  FILENAME=$(basename "$f" | sed "s/.tpl//g" | sed "s/_//g" | awk '{print tolower($0)}')
  echo "$f"
  echo "- [$FILENAME](./$FILENAME.md)" >> "${PATH_TO_DOCS}/README.md"

  echo "# ${FILENAME}" | tr '[:lower:]' '[:upper:]' > "${PATH_TO_DOCS}/$FILENAME.md"
  # shellcheck disable=SC2129
  awk '/END/{found=0} {if(found) print} /START/{found=1}' "$f" >> "${PATH_TO_DOCS}/$FILENAME.md"

  echo "___" >> "${PATH_TO_DOCS}/$FILENAME.md"
  echo "Return to [Common components](./README.md)" >> "${PATH_TO_DOCS}/$FILENAME.md"
  # git add "${PATH_TO_DOCS}/$FILENAME.md"
done

echo "___" >> "${PATH_TO_DOCS}/README.md"
echo "Return to [Common](../README.md)" >> "${PATH_TO_DOCS}/README.md"

# git add "${PATH_TO_DOCS}/README.md"
