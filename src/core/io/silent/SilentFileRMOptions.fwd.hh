// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file   core/io/silent/SilentFileRMOptions.fwd.hh
/// @brief  Forward Header for options for constructing a pose from a silent file
/// @author Matthew O'Meara (mattjomeara@gmail.com)

#ifndef INCLUDED_core_io_silent_SilentFileRMOptions_fwd_hh
#define INCLUDED_core_io_silent_SilentFileRMOptions_fwd_hh

//Utility headers
#include <utility/pointer/owning_ptr.hh>

namespace core {
namespace io {
namespace silent {

class SilentFileRMOptions;
typedef utility::pointer::shared_ptr< SilentFileRMOptions > SilentFileRMOptionsOP;
typedef utility::pointer::shared_ptr< SilentFileRMOptions const > SilentFileRMOptionsCOP;

} // namespace
} // namespace
} // namespace

#endif
