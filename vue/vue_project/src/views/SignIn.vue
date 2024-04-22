<template>
  <div class="top-page">
    <div class="body">
      <div class="title">ログインページ</div>
      <div class="tab">
        <router-link class="link-list" :to="{ name: 'TopPage' }"
          >Top</router-link
        >
        <router-link class="link-list" :to="{ name: 'SignUp' }"
          >新規登録</router-link
        >
        <router-link class="link-list" :to="{ name: 'SignIn' }"
          >サインイン</router-link
        >
      </div>
      <div class="input-form">
        <p>(氏名または)メールアドレス</p>
        <input type="text" v-model="inputEmail" placeholder="..@....com" />
        <p>パスワード</p>
        <input type="text" v-model="inputPassword" />
        <p></p>
        <!--<input class="input-sample-item-text" type="text" v-model="inputText" -->
        <div class="box-class" @click="login">ログイン</div>
        <p>userIdの確認: {{ this.$store.getters.userId }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "SignIn",
  data() {
    return {
      inputName: "",
      inputEmail: "",
      inputPassword: "",
      link_to: { name: "" },
    };
  },
  methods: {
    async addUserData() {
      //console.log("addUserDataをします(SignUp)")
      //this.$router.push({ name: SignIn });
      if (!this.inputName) {
        return window.alert("名前を入力してください");
      }
      if (!this.inputEmail) {
        return window.alert("メールアドレスを入力してください");
      }
      if (this.inputPassword != this.inputPasswordForCheck) {
        return window.alert("パスワードエラー");
      }
      //window.alert("addUserDataをします(SignUp)");

      this.link_to = await this.$store.dispatch("addUserData", {
        inputName: this.inputName,
        inputEmail: this.inputEmail,
        inputPassword: this.inputPassword,
      });
      //alert(this.link_to.name); //SignIn
      this.$router.push(this.link_to);
    },
    //a2.からじゃなければ、'addSampleItem'を行う、その際に this.inputTextを text として引き渡す
    async login() {
      if (!this.inputEmail) {
        return window.alert("メールを入力してください");
      }
      if (!this.inputPassword) {
        return window.alert("パスワードエラー");
      }
      const res = await this.$store.dispatch("login", {
        inputEmail: this.inputEmail,
        inputPassword: this.inputPassword,
      });
      //alert("SignIn:" + res);
      //alert("SignIn:" + this.$store.state.userId);
      //alert("SignIn:" + this.$store.state.isLoggedIn);
      if (this.$store.getters.isLoggedIn) {
        this.$router.push({ name: "TopPage" });
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.top-page {
  background-color: rgb(193, 238, 235);
  min-height: 1200px;
  padding: 5% 0px;
  .body {
    width: 80%;
    //text-align: center;
    margin: 0px auto;
    //margin: 30px;
  }
  .title {
    font-size: 36px;
    font-weight: bold;
    margin: 30px;
  }
  .box-class {
    margin-bottom: 5px;
    font-size: 20px;
    display: inline-block;
    padding: 10px 30px;
    right: 4px;
    bottom: 4px;
    border: 2px solid black;
    border-radius: 5px;
    background-color: beige;
    text-decoration: none;
  }
  .box-class:hover {
    background-color: rgb(233, 233, 94);
    right: 40px;
    bottom: 4px;
  }
  .tab {
    padding: 10px;
    margin: 30px;
    .link-list {
      font-size: 20px;
      background-color: aqua;
      margin: 10px;
      padding: 5px;
      border: 2px solid #000000;
      border-radius: 5px;
      text-decoration: none;
    }
    .link-list:hover {
      background-color: rgb(159, 159, 231);
    }
  }
  .input-form input {
    font-size: 14px;
    height: 40px;
    width: 500px;
    border: 2px solid #324c2c;
    border-radius: 8px;
    //box-shadow: 5px 5px 5px #0f4703;
  }
  .input-form p {
    font-size: 20px;
    font-weight: bold;
    margin: 3px;
  }
}
</style>
