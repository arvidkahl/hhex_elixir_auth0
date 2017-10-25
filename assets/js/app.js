import "phoenix_html"
import Vue from 'vue'
import VueResource from 'vue-resource'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/en'

Vue.use(ElementUI, { locale })
import VueRouter from 'vue-router'
Vue.use(VueRouter)
Vue.use(VueResource)

var EventBus = new Vue()
Object.defineProperties(Vue.prototype, {
    $bus: {
        get: function () {
            return EventBus;
        }
    }
})

import AuthService from './authservice.js'
import MainView from './auth.vue'

const routes = [
  { path: '/', component: MainView},
]

const router = new VueRouter({routes})

Vue.http.interceptors.push(function(request, next) {

  //  Add JWT to every outgoing request
  request.headers.set('Authorization', 'Bearer ' + localStorage.getItem('id_token'));

  // Check responses for 401, which means invalid token. In that case, log out user immediately
  next(function(response){

    if(response.status === 401) {
      main.$auth.logout();
      main.$router.push('/');
    }
    return response;
  });
});


const main = new Vue({
  router: router,
  created(){
    this.$bus.$on('loggedIn', ()=>{
      this.$router.push("/")
    })
  },
}).$mount('#app');
