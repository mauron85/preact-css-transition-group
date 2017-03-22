import path from 'path';
import fs from 'fs';
import babel from 'rollup-plugin-babel';
import nodeResolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import alias from 'rollup-plugin-alias';
import replace from 'rollup-plugin-replace';

let pkg = JSON.parse(fs.readFileSync('./package.json'));

let external = Object.keys(pkg.peerDependencies || {}).concat(Object.keys(pkg.dependencies || {}));
delete external.fbjs;

export default {
	entry: 'src/index.js',
	dest: pkg.main,
	sourceMap: path.resolve(pkg.main),
	moduleName: pkg.amdName,
	format: 'umd',
	external,
	plugins: [
		babel({
			babelrc: false,
			comments: false,
			exclude: 'node_modules/**',
			presets: [
				'es2015-loose-rollup',
				'stage-0',
				'react'
			],
			plugins: [
				'transform-class-properties',
				['transform-es2015-classes', { loose:true }],
				['transform-react-jsx', { pragma:'h' }]
			]
		}),
		replace({
			'__DEV__': false
		}),
		alias({
			// force fbjs to use our modules
			'./invariant': './../../../src/invariant',
			'./warning': './../../../src/warning',
			'fbjs/lib/invariant': './invariant',
			'fbjs/lib/warning': './warning',
			resolve: ['.js']
		}),
		nodeResolve({
			jsnext: true,
			main: true,
			skip: external
		}),
		commonjs({
			include: 'node_modules/**',
			exclude: '**/*.css'
		})
	]
};
