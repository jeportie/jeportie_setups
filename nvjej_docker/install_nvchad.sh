#!/bin/bash
echo "Starting NVChad installation in headless mode..."
# Trigger NVChad's lazy loading and run MasonInstallAll.
nvim --headless +"autocmd User LazyVimStarted MasonInstallAll | qa" || {
  echo "NVChad installation failed. Please check your configuration."
  exit 1
}
echo "NVChad plugins installed successfully."
