import React from 'react';
import SearchBar from './SearchBar';
import GifCard from './GifCard';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      searchTerm: "",
      gifs: []
    };
  };

  changeSearchTerm = (event) => {
    this.setState( {
      searchTerm: event.target.value
    } )
  }

  getGifs = () => {
    fetch("http://localhost:4000/get_gifs", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({
        searchTerm: this.state.searchTerm
      })
    })
      .then( function(response){
        return response.clone().json()
      }).then(response => this.setState({ gifs: [...this.state.gifs, JSON.parse(response).downsized]}))
  }

  refresh = () => {
    this.setState({gifs: []});
  };

  render() {
    return(
      <div>
        <SearchBar
          searchTerm={this.state.searchTerm}
          changeSearchTerm={this.changeSearchTerm}
          getGifs={this.getGifs}
          refreshGifs={this.refresh}
        />

        {
          this.state.gifs.map( gifObj =>
            <GifCard key={gifObj.url} gifObj={gifObj} />
          )
        }

      </div>
    )
  }
}

export default App
