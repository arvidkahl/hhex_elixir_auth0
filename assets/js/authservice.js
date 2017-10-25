import Vue from 'vue'
import {Message} from 'element-ui'

function checkAuth() {
  return !!localStorage.getItem('id_token');
}

var AuthService = new Vue({
  data() {
    return {
      authenticated: false,
      profile: {},
      lock: new Auth0Lock(window.authAppKey, 'INSERT_YOUR_AUTH0_BASEURL_HERE', {
        auth: {
          responseType: "id_token",
          params: {
            scope: 'openid email profile'
          }
        },
        languageDictionary: {
          title: "HH.ex"
        }
      })
    }
  },
  created() {
    this.authenticated = checkAuth();

    try {
      this.profile = JSON.parse(localStorage.getItem('profile'));
    } catch(e) {
      this.profile = {}
    }

    this.lock.on('authenticated', (authResult) => {
      localStorage.setItem('id_token', authResult.idToken);

      localStorage.setItem('profile', JSON.stringify(authResult.idTokenPayload));
      this.profile = authResult.idTokenPayload

      this.authenticated = checkAuth();

      Message.success("Thank you for logging in.")
      this.$bus.$emit("loggedIn")
    });

    this.lock.on('authorization_error', (error) => {
      console.log("Authorization error", error)
      Message.error("Could not log in.")
    });
  },
  methods: {
    getProfile(){
      return this.profile;
    },
    login() {
      let options = {
        initialScreen: 'login'
      }
      this.lock.show(options);
    },
    intentionalLogout(){
      this.logout();
      Message("You were logged out!");
    },
    logout() {
      localStorage.removeItem('id_token');
      localStorage.removeItem('profile');
      this.authenticated = false;
      this.profile = {};
    }
  }

})

Object.defineProperties(Vue.prototype, {
    $auth: {
        get: function () {
            return AuthService;
        }
    }
})
