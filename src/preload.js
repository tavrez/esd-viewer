const { contextBridge, ipcRenderer } = require('electron/renderer')

contextBridge.exposeInMainWorld('API', {
  openFile: () => ipcRenderer.invoke('openFile')
})
