module.exports = {
  require(filePath) {
    let splitDir = __dirname.split("/");
    splitDir.shift();

    let appRootIndex;
    splitDir.map((dir, i) => {
      // ※package.jsonの```jest.globals.appRootDirname```にrailsのルートフォルダの名前をセットしておく
      if (dir === appRootDirname) {
        appRootIndex = i + 1;
      }
    });

    splitDir.splice(appRootIndex, splitDir.length - appRootIndex);
    splitDir = splitDir.concat("app/assets/javascripts".split("/"));
    splitDir = splitDir.concat(filePath.split("/"));

    return splitDir.join("/");
  }
};
