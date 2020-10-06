SPACESHIP_ANGULAR_SHOW="${SPACESHIP_ANGULAR_SHOW:=true}"
SPACESHIP_ANGULAR_PREFIX="${SPACESHIP_ANGULAR_PREFIX:="with "}"
SPACESHIP_ANGULAR_SUFFIX="${SPACESHIP_ANGULAR_SUFFIX:="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_ANGULAR_SYMBOL="${SPACESHIP_ANGULAR_SYMBOL:="🅰️  "}"
SPACESHIP_ANGULAR_COLOR="${SPACESHIP_ANGULAR_COLOR:="red"}"


_get_angular_version() {
  local pkg_path="node_modules/$1/package.json"
  if [[ -f "$pkg_path" ]]; then
    local pkg_version=$(grep -E '"version": "v?([0-9]+\.){1,}' "$pkg_path" | cut -d\" -f4 2> /dev/null)
  fi

  if [[ $pkg_version ]]; then
    echo $pkg_version
  else
    node -p "r=require('./package.json'); r.devDependencies['$1'] || r.dependencies['$1']" 2>/dev/null
  fi
}

spaceship_angular() {

  [[ $SPACESHIP_ANGULAR_SHOW == false ]] && return

  local version=$(_get_angular_version "@angular/core")

  [[ $version == "undefined" || $version == "" ]] && return

  spaceship::section \
    "$SPACESHIP_ANGULAR_COLOR" \
    "$SPACESHIP_ANGULAR_PREFIX" \
    "${SPACESHIP_ANGULAR_SYMBOL}v${version}" \
    "$SPACESHIP_ANGULAR_SUFFIX"
}
