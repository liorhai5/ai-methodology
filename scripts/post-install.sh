#!/bin/sh
# ai-stack postInstall for mtg (ai-methodology)

# Copy methodology template to stable path
mkdir -p "$AIS_DATA_DIR"
cp "$AIS_PLUGIN_SOURCE/templates/methodology-template.tpl" "$AIS_DATA_DIR/methodology-template.tpl"
