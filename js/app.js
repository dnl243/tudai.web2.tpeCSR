"use strict";

document.addEventListener("DOMContentLoaded", () => {
  const BASE_URL_API = "api/";

  let moviesData = [];
  let userData = [];
  let formSignIn;
  let formSignUp;
  let captcha;
  let mainContent = document.querySelector("#mainContent");

  /* -- data logic -- */

  async function getMovies() {
    try {
      const response = await fetch(BASE_URL_API + "movies");
      if (!response.ok) {
        throw new Error("Error to get movies");
      }
      moviesData = await response.json();
      showHome();
    } catch (error) {
      console.log(error);
    }
  }

  async function getMovieById(idMovie) {
    try {
      const response = await fetch(BASE_URL_API + "movies/" + idMovie);
      if (!response.ok) {
        throw new Error("Error to get movie");
      }
      moviesData = await response.json();
      showOverview();
    } catch (error) {
      console.log(error);
    }
  }

  async function getGenres() {
    try {
      const response = await fetch(BASE_URL_API + "genres");
      if (!response.ok) {
        throw new Error("Error to get genres");
      }
      moviesData = await response.json();
      showGenres();
    } catch (error) {
      console.log(error);
    }
  }

  async function getMoviesByGenre(genre) {
    try {
      const response = await fetch(
        BASE_URL_API + "movies?filter=main_genre&filterValue=" + genre
      );
      if (!response.ok) {
        throw new Error("Error to get genres");
      }
      moviesData = await response.json();
      showHome();
    } catch (error) {
      console.log(error);
    }
  }

  async function getToken() {
    try {
      let response = await fetch(BASE_URL_API + "usuarios/token", {
        method: "GET",
        headers: {
          Authorization: "Basic " + userData,
          "Content-Type": "application/json",
        },
      });
      if (!response.ok) {
        throw new Error("Error del servidor");
      }
      let token = await response.text();
      token = token.replace(/"/g, "");
      console.log("Bearer " + token);

      // signIn(token);
    } catch (e) {
      console.log(e);
    }
  }
  /* -- navigation logic -- */

  function select_tab(id) {
    // remove selected class from all buttons
    document
      .querySelectorAll(".nav-link")
      .forEach((item) => item.classList.remove("selected"));
    // select clicked element (visually)
    document
      .querySelectorAll("#" + id)
      .forEach((item) => item.classList.add("selected"));
  }
  function load_content(id) {
    switch (id) {
      case "home":
        getMovies();
        break;
      case "genres":
        getGenres();
        break;
      case "signIn":
        showSignIn();
        break;
      /************************* */
      case "signOut":
        showSignOut();
        break;
      case "signUp":
        showSignUp();
        break;
      // case "admin":
      //   showAdmin();
      //   break;
    }
  }
  function push(event) {
    // Get id atribute of the box or button or link clicked
    let id = event.target.id;
    // Visually selected the clicked button/tab/box
    select_tab(id);
    // Update title in Window´s Tab
    document.title = id;
    // Load content for this tab/page
    load_content(id);
    // Finally push state change to the address bar
    location.pathname === `/${id}`
      ? window.history.replaceState({ id }, `${id}`, id)
      : window.history.pushState({ id }, `${id}`, id);
  }
  // load by default
  function loadByDefault(id) {
    select_tab(id);
    document.title = id;
    load_content(id);
    window.history.replaceState({ id }, `${id}`, id);
  }
  window.history.state
    ? loadByDefault(window.history.state.id)
    : loadByDefault("home");
  // Add history push() event when boxes are clicked
  document
    .querySelector("#home")
    .addEventListener("click", (event) => push(event));
  document
    .querySelector("#genres")
    .addEventListener("click", (event) => push(event));
  document
    .querySelector("#signIn")
    .addEventListener("click", (event) => push(event));
  document
    .querySelector("#signOut")
    .addEventListener("click", (event) => push(event));
  document
    .querySelector("#signUp")
    .addEventListener("click", (event) => push(event));
  // document
  //   .querySelector("#admin")
  //   .addEventListener("click", (event) => push(event));
  // Listen for PopStateEvent (Back or Forward buttons are clicked)
  window.addEventListener("popstate", (event) => {
    if (!event.state) {
      return;
    }
    // Grab the history state id
    let stateId = event.state.id;
    // Show clicked id in console  ( just for fun )
    // console.log("stateId = ", stateId);
    // Visually select the clicked button/tab/box
    select_tab(stateId);
    // Load content for this tab/page
    load_content(stateId);
  });

  /* -- home content -- */

  function showHome() {
    let moviesContainer = document.createElement("div");
    moviesContainer.setAttribute(
      "class",
      "d-flex justify-content-center flex-wrap"
    );

    moviesData.forEach((element) => {
      let divCard = document.createElement("div");
      divCard.setAttribute("class", "card text-bg-dark m-2");
      divCard.setAttribute("style", "width: 12rem;");

      let img = document.createElement("img");
      img.setAttribute("src", element.poster_path);
      img.setAttribute("class", "card-img opacity-75");
      img.setAttribute("alt", "img movie");
      divCard.appendChild(img);

      let divLink = document.createElement("div");
      divLink.setAttribute("class", "card-img-overlay d-flex align-items-end");
      divCard.appendChild(divLink);

      let aLink = document.createElement("a");
      aLink.setAttribute("href", element.id_movie);
      aLink.setAttribute("style", "text-decoration: none; color: white;");
      divLink.appendChild(aLink);

      let h5Title = document.createElement("h5");
      h5Title.setAttribute("class", "card-title");
      h5Title.setAttribute("data-id", element.id_movie);
      h5Title.innerHTML = element.title;
      aLink.appendChild(h5Title);

      moviesContainer.appendChild(divCard);
    });
    mainContent.innerHTML = "";
    mainContent.appendChild(moviesContainer);
    configHome();
  }

  function configHome() {
    document.querySelectorAll(".card-title").forEach((element) => {
      element.addEventListener("click", (event) => {
        event.preventDefault();
        getMovieById(event.target.dataset.id);
      });
    });
  }

  function showOverview() {
    let movieContainer = document.createElement("div");
    movieContainer.setAttribute(
      "class",
      "container-fluid d-flex justify-content-center flex-wrap"
    );

    let divCard = document.createElement("div");
    divCard.setAttribute("class", "card mt-3 border-secondary");
    divCard.setAttribute("style", "max-width: 740px;");
    movieContainer.appendChild(divCard);

    let divRow = document.createElement("div");
    divRow.setAttribute("class", "row g-0");
    divCard.appendChild(divRow);

    let divCol = document.createElement("div");
    divCol.setAttribute("class", "col-md-6");
    divRow.appendChild(divCol);

    let img = document.createElement("img");
    img.setAttribute("src", moviesData.poster_path);
    img.setAttribute("class", "img-fluid rounded-start");
    img.setAttribute("alt", "img movie");
    divCol.appendChild(img);

    let divCol2 = document.createElement("div");
    divCol2.setAttribute("class", "col-md-6");
    divRow.appendChild(divCol2);

    let divCardBoby = document.createElement("div");
    divCardBoby.setAttribute("class", "card-body");
    divCol2.appendChild(divCardBoby);

    let h5Title = document.createElement("h5");
    h5Title.setAttribute("class", "card-title");
    h5Title.innerHTML = moviesData.title;
    divCardBoby.appendChild(h5Title);

    let pText = document.createElement("p");
    pText.setAttribute("class", "card-text");
    pText.innerHTML = moviesData.overview;
    divCardBoby.appendChild(pText);

    let pText2 = document.createElement("p");
    pText2.setAttribute("class", "card-text");
    divCardBoby.appendChild(pText);

    let small = document.createElement("small");
    small.setAttribute("class", "text-body-secondary");
    small.innerHTML = moviesData.release_date;
    pText2.appendChild(small);

    let divCardBody2 = document.createElement("div");
    divCardBody2.setAttribute("class", "card-body");
    divCol2.appendChild(divCardBody2);

    let pText3 = document.createElement("p");
    pText3.setAttribute("class", "card-text");
    pText3.innerHTML = moviesData.company;
    divCardBody2.appendChild(pText3);

    let aLinkGenre = document.createElement("a");
    aLinkGenre.setAttribute("class", "card-link genre-link");
    aLinkGenre.setAttribute("href", moviesData.main_genre);
    aLinkGenre.innerHTML = moviesData.main_genre;
    divCardBody2.appendChild(aLinkGenre);

    if (moviesData.reviews) {
      let aLinkReview = document.createElement("a");
      aLinkReview.setAttribute("class", "card-link review-link");
      aLinkReview.setAttribute("href", "reviews");
      aLinkReview.innerHTML = "opiniones";
      divCardBody2.appendChild(aLinkReview);
    }

    mainContent.innerHTML = "";
    mainContent.appendChild(movieContainer);

    configOverview();
    if (moviesData.reviews) {
      configReviewLink();
    }
  }

  function configOverview() {
    document.querySelector(".genre-link").addEventListener("click", (event) => {
      event.preventDefault();
      getMoviesByGenre(moviesData.main_genre);
    });
  }

  function configReviewLink() {
    document
      .querySelector(".review-link")
      .addEventListener("click", (event) => {
        event.preventDefault();
        showReview();
      });
  }

  function showReview() {
    let movieContainer = document.createElement("div");
    movieContainer.setAttribute(
      "class",
      "container-fluid d-flex justify-content-center flex-wrap"
    );

    let divCard = document.createElement("div");
    divCard.setAttribute("class", "card mt-3 border-secondary");
    divCard.setAttribute("style", "max-width: 740px;");
    movieContainer.appendChild(divCard);

    let divRow = document.createElement("div");
    divRow.setAttribute("class", "row g-0");
    divCard.appendChild(divRow);

    let divCol = document.createElement("div");
    divCol.setAttribute("class", "col-md-6");
    divRow.appendChild(divCol);

    let img = document.createElement("img");
    img.setAttribute("src", moviesData.poster_path);
    img.setAttribute("class", "img-fluid rounded-start");
    img.setAttribute("alt", "img movie");
    divCol.appendChild(img);

    let divCol2 = document.createElement("div");
    divCol2.setAttribute("class", "col-md-6");
    divRow.appendChild(divCol2);

    let divCardBoby = document.createElement("div");
    divCardBoby.setAttribute("class", "card-body");
    divCol2.appendChild(divCardBoby);

    let qualification = 0;

    let h5Title = document.createElement("h5");
    h5Title.setAttribute("class", "card-title");
    divCardBoby.appendChild(h5Title);

    moviesData.reviews.forEach((element) => {
      let review = document.createElement("p");
      review.innerHTML = '"' + element.main_review + '"';
      review.innerHTML += "<br>Puntuación = " + element.score + ".";
      qualification += element.score;
      divCardBoby.appendChild(review);
    });

    h5Title.innerHTML =
      "Opiniones (Puntuación = " +
      (qualification / moviesData.reviews.length).toFixed(1) +
      " )";

    let divCardBody2 = document.createElement("div");
    divCardBody2.setAttribute("class", "card-body");
    divCol2.appendChild(divCardBody2);

    let aLinkOverview = document.createElement("a");
    aLinkOverview.setAttribute("class", "card-link overview-link");
    aLinkOverview.setAttribute("href", "overview");
    aLinkOverview.innerHTML = "resumen";
    divCardBody2.appendChild(aLinkOverview);

    mainContent.innerHTML = "";
    mainContent.appendChild(movieContainer);

    configReview();
  }

  function configReview() {
    document
      .querySelector(".overview-link")
      .addEventListener("click", (event) => {
        event.preventDefault();
        showOverview();
      });
  }

  /* -- genres content -- */

  function showGenres() {
    let genresContainer = document.createElement("div");
    genresContainer.setAttribute(
      "class",
      "container-fluid d-flex justify-content-center"
    );

    let listContainer = document.createElement("div");
    listContainer.setAttribute("class", "list-group mt-3");
    genresContainer.appendChild(listContainer);

    moviesData.forEach((element) => {
      let aLinkGenre = document.createElement("a");
      aLinkGenre.setAttribute(
        "class",
        "list-group-item list-group-item-action border-secondary genre-link"
      );
      aLinkGenre.setAttribute("data-id", element.main_genre);
      aLinkGenre.setAttribute("href", element.main_genre);
      aLinkGenre.innerHTML = element.main_genre;
      listContainer.appendChild(aLinkGenre);
    });

    mainContent.innerHTML = "";
    mainContent.appendChild(genresContainer);

    configGenres();
  }

  function configGenres() {
    document.querySelectorAll(".genre-link").forEach((element) => {
      element.addEventListener("click", (event) => {
        event.preventDefault();
        getMoviesByGenre(event.target.dataset.id);
      });
    });
  }

  /* -- signIn content -- */

  function showSignIn() {
    let signInContainer = document.createElement("div");
    signInContainer.setAttribute(
      "class",
      "container-fluid mt-3 d-flex justify-content-center"
    );

    let formSignIn = document.createElement("form");
    formSignIn.setAttribute("id", "formSignIn");
    formSignIn.setAttribute("method", "post");
    formSignIn.setAttribute("class", "text-center");
    signInContainer.appendChild(formSignIn);

    let divEmail = document.createElement("div");
    divEmail.setAttribute("class", "mb-3");
    formSignIn.appendChild(divEmail);

    let inputEmail = document.createElement("input");
    inputEmail.setAttribute("type", "email");
    inputEmail.setAttribute("name", "email");
    inputEmail.setAttribute("class", "form-control");
    inputEmail.setAttribute("required", true);
    inputEmail.setAttribute("placeholder", "email");
    inputEmail.setAttribute("autocomplete", "email");
    divEmail.appendChild(inputEmail);

    let divPass = document.createElement("div");
    divPass.setAttribute("class", "mb-3");
    formSignIn.appendChild(divPass);

    let inputPass = document.createElement("input");
    inputPass.setAttribute("type", "password");
    inputPass.setAttribute("name", "password");
    inputPass.setAttribute("class", "form-control");
    inputPass.setAttribute("required", true);
    inputPass.setAttribute("placeholder", "password");
    inputPass.setAttribute("autocomplete", "current-password");
    divPass.appendChild(inputPass);

    let btnSignIn = document.createElement("button");
    btnSignIn.setAttribute("type", "submit");
    btnSignIn.setAttribute("class", "btn btn-primary");
    btnSignIn.innerHTML = "Sign In";
    formSignIn.appendChild(btnSignIn);

    mainContent.innerHTML = "";
    mainContent.appendChild(signInContainer);
    configSignIn();
  }

  function configSignIn() {
    formSignIn = document.querySelector("#formSignIn");
    formSignIn.addEventListener("submit", loadDataSignIn);
  }

  function loadDataSignIn(e) {
    e.preventDefault();

    let formData = new FormData(formSignIn);
    let email = formData.get("email");
    let password = formData.get("password");
    console.log(email + " " + password);

    userData.push(email);
    userData.push(password);

    userData = userData.join(":");
    console.log(userData);

    userData = btoa(userData);
    console.log("Basic " + userData);

    formSignIn.reset();
    getToken();
  }

  /* -- signOut content -- */

  function showSignOut() {
    console.log("estas en SignOut");
  }

  /* -- signUp content -- */

  function generateCaptcha() {
    const chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let captcha = "";
    for (let i = 0; i < 6; i++) {
      captcha += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return captcha;
  }

  function showSignUp() {
    let signUpContainer = document.createElement("div");
    signUpContainer.setAttribute(
      "class",
      "container-fluid mt-3 d-flex justify-content-center"
    );

    let formSignUp = document.createElement("form");
    formSignUp.setAttribute("id", "formSignUp");
    formSignUp.setAttribute("method", "post");
    formSignUp.setAttribute("class", "text-center");
    signUpContainer.appendChild(formSignUp);

    let divEmail = document.createElement("div");
    divEmail.setAttribute("class", "mb-3");
    formSignUp.appendChild(divEmail);

    let inputEmail = document.createElement("input");
    inputEmail.setAttribute("type", "email");
    inputEmail.setAttribute("name", "email");
    inputEmail.setAttribute("class", "form-control");
    inputEmail.setAttribute("required", true);
    inputEmail.setAttribute("placeholder", "email");
    inputEmail.setAttribute("autocomplete", "email");
    divEmail.appendChild(inputEmail);

    let divPass = document.createElement("div");
    divPass.setAttribute("class", "mb-3");
    formSignUp.appendChild(divPass);

    let inputPass = document.createElement("input");
    inputPass.setAttribute("type", "password");
    inputPass.setAttribute("name", "password");
    inputPass.setAttribute("class", "form-control");
    inputPass.setAttribute("required", true);
    inputPass.setAttribute("placeholder", "password");
    inputPass.setAttribute("autocomplete", "current-password");
    divPass.appendChild(inputPass);

    let divCaptcha = document.createElement("div");
    divCaptcha.setAttribute("class", "mb-3");
    formSignUp.appendChild(divCaptcha);

    captcha = generateCaptcha();

    let inputCaptcha = document.createElement("input");
    inputCaptcha.setAttribute("type", "text");
    inputCaptcha.setAttribute("id", "captchaText");
    inputCaptcha.setAttribute("class", "form-control");
    inputCaptcha.setAttribute("readonly", true);
    inputCaptcha.setAttribute("placeholder", captcha);
    divCaptcha.appendChild(inputCaptcha);

    let divCode = document.createElement("div");
    divCode.setAttribute("class", "mb-3");
    formSignUp.appendChild(divCode);

    let inputCode = document.createElement("input");
    inputCode.setAttribute("type", "text");
    inputCode.setAttribute("name", "captchaCode");
    inputCode.setAttribute("class", "form-control");
    inputCode.setAttribute("required", true);
    inputCode.setAttribute("placeholder", "captcha");
    divCode.appendChild(inputCode);

    let btnSignIn = document.createElement("button");
    btnSignIn.setAttribute("type", "submit");
    btnSignIn.setAttribute("class", "btn btn-primary");
    btnSignIn.innerHTML = "Sign Up";
    formSignUp.appendChild(btnSignIn);

    mainContent.innerHTML = "";
    mainContent.appendChild(signUpContainer);
    configSignUp();
  }

  function configSignUp() {
    formSignUp = document.querySelector("#formSignUp");
    formSignUp.addEventListener("submit", loadDataSignUp);
  }

  function loadDataSignUp(e) {
    e.preventDefault();

    let formData = new FormData(formSignUp);
    let email = formData.get("email");
    let password = formData.get("password");
    let captchaCode = formData.get("captchaCode");

    if (captcha === captchaCode) {
      console.log(email + " " + password);

      userData.push(email);
      userData.push(password);

      Swal.fire({
        icon: "success",
        title: "WelCome",
        text: "You have successfully registered!",
      });
    } else {
      Swal.fire({
        icon: "error",
        title: "Oops...",
        text: "Wrong captcha, try again",
      });
      showSignUp();
    }
  }

  /* -- admin content -- */

  // function showAdmin() {
  //   console.log("estas en Admin");
  // }
});
