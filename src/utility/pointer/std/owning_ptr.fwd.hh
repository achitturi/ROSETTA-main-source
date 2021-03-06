// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file   utility/pointer/std/owning_ptr.fwd.hh
/// @brief  Owning smart pointer using C++11
/// @author Luki Goldschmidt <lugo@uw.edu>


#ifndef INCLUDED_utility_pointer_std_owning_ptr_fwd_hh
#define INCLUDED_utility_pointer_std_owning_ptr_fwd_hh

#ifdef PTR_STD

#include <memory>

namespace utility {
namespace pointer {

	using std::shared_ptr;

}
}

#endif // PTR_STD


#endif // INCLUDED_utility_pointer_std_owning_ptr_fwd_hh
