<template lang="html">
  <div class="container">
    <el-row :gutter="10">
      <el-col :span="12">
        Logged in: {{ $auth.authenticated }}
        <el-button v-show="$auth.authenticated == false" @click="login()">Login</el-button>
        <el-button v-show="$auth.authenticated == true"@click="logout()">Logout</el-button>
        <pre><code>Profile: {{ $auth.profile}}</code></pre>
      </el-col>
      <el-col :span="12">
        <el-button @click="fetchData()">Get data from API</el-button>
        <pre><code>Data: {{data}}</code></pre>
      </el-col>
    </el-row>
  </div>

</template>

<script>

import {Message} from 'element-ui'
export default {
  data(){
    return {
      data: null
    }
  },
  methods: {
    fetchData(){
      this.$http.get("/api").then((res)=>{
        this.data = res.body
      }, (err)=>{
        Message.error(err.status+": "+err.statusText)
      })
    },
    login(){
      this.$auth.login()
    },
    logout(){
      this.$auth.intentionalLogout()
    }
  }
}
</script>

<style lang="css">
</style>
