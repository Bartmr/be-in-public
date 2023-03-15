const path = require('path');
const CopyPlugin = require("copy-webpack-plugin");

module.exports = {
  entry: {
    'packages/git/check-branch-protection/check-branch-protection': './src/packages/git/check-branch-protection/check-branch-protection.ts'
  },
  target: 'node',
  devtool: 'source-map',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: [
          {
            loader: 'ts-loader',
            options: {
              transpileOnly: true
            }
          }
        ]
      }
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  plugins: [
    new CopyPlugin({
      patterns: [
        "src/project.yml",
        {
          from: 'src/**/package.json',
          to: ({ absoluteFilename}) => {

            return absoluteFilename.replace(
              srcAbsolutePath = path.resolve(__dirname, "src"),
              srcAbsolutePath = path.resolve(__dirname, "build")
            )
          },

        }
      ]
    })
  ],
  output: {
    path: path.join(__dirname, 'build'),
    filename: '[name].js',
    libraryTarget: 'commonjs',
  },
};