<?php
 /**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'admin' );

/** MySQL database password */
define( 'DB_PASSWORD', 'admin' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql:3306' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'b!Yw.f=-f_ThU[0Z|jA#>5+gi~,uLfC)Wu?q^AsKO|z.G/)y0X ucP.cnia8^aMa');
define('SECURE_AUTH_KEY',  '=}F6%)[aP^w_N6C PnqDk~lahr.5jR*e1xz>W|/7-a!Gzon7~G271aH;&L<.?A0g');
define('LOGGED_IN_KEY',    'C_k0|*:zx.-yjN}(EN2?hRpxh`Vz;En)ZHyN4~&6.!-hmTKO8pAe;#Ae^+*-&NGw');
define('NONCE_KEY',        'A@v5B(ZB.7NM}eV^{.LramQX6ay@#3!(0Z+/0:7&yX9Y5.}n*O0|[&*R8__}6IHt');
define('AUTH_SALT',        'E$#T84MX-D i@-rjdC?<-Oz91t!fQWC$ nhHE<lt6Kn30y`k[g &83LIq:T^HAb)');
define('SECURE_AUTH_SALT', '3HM}=EWQ):bhA]{@{mY^292BoW1f2G~c+|54pCGhNZh(GF#PIYrHBI7ee-HXd+:q');
define('LOGGED_IN_SALT',   'myF-JT.R;7J5]pO%ENut/A;5?k1t}IP^+9dG4>V$7+7UdVH)|O4zSX2!A-p)I,k*');
define('NONCE_SALT',       'kI^876G]Vdk{O? Z.S5gIavf1fS&Tlaij}+nAK&D2QzS/z>.OKGK#%oagIXwLP0q');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
