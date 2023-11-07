const { app, BrowserWindow, dialog, ipcMain, shell } = require('electron/main');
const path = require('node:path');

const createWindow = () => {
	const win = new BrowserWindow({
		width: 800,
		height: 600,
		center: true,
		title: 'Products.xml',
		webPreferences: {
			preload: path.join(__dirname, 'preload.js'),
		},
	});

	win.removeMenu();

	win.loadFile(path.join(__dirname, 'index.html'));

	win.webContents.setWindowOpenHandler(({ url }) => {
		shell.openExternal(url);
		return { action: 'deny' };
	});
};

app.whenReady().then(() => {
	ipcMain.handle('openFile', () =>
		dialog.showOpenDialog({
			title: 'Select File',
			filters: [{ name: 'products.xml', extensions: ['xml'] }],
			properties: ['openFile'],
		})
	);

	createWindow();

	app.on('activate', () => {
		if (BrowserWindow.getAllWindows().length === 0) {
			createWindow();
		}
	});
});

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') {
		app.quit();
	}
});
