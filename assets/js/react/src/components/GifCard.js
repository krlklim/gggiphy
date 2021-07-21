import React from 'react'
import '../../../../css/app.scss'

const GifCard = ( { gifObj } ) => {
  return (
    <div className="ui card">
      <img className="align-center" style={{width: 500}} src={gifObj.url} alt="gif"/>
    </div>
  )
}

export default GifCard
