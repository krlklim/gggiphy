import React from 'react'

const SearchBar = ( { searchTerm, changeSearchTerm, getGifs, refreshGifs } ) => {
  return (
    <div>
      <input
        className="ui input search"
        type="text"
        placeholder="Search powered by Giphy..."
        value={searchTerm}
        onChange={changeSearchTerm}
      />

      <input
        type="submit"
        value="Hit Me with Some GIFs!"
        onClick={ () => { refreshGifs(); getGifs() } }
      />
    </div>
  )
}

export default SearchBar
